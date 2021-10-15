---
title: 첫번째 프로젝트
category: project_fullstack
---

## 테니스 점수판

**Main**

```java
package tennis;

import static tennis.Condition.isDeuce;
import static tennis.Condition.isForty;
import static tennis.Condition.overFortyfive;
import static tennis.Condition.setEnded;
import static tennis.Tennis.checkBoard;
import static tennis.Tennis.curGame;
import static tennis.Tennis.dispScoreBoard;
import static tennis.Tennis.players;
import static tennis.Tennis.pointWinner;
import static tennis.Tennis.printSetResult;
import static tennis.Tennis.resetBoardAndScore;
import static tennis.Tennis.saveScoreBoard;
import static tennis.Tennis.scoreBoard;
import static tennis.Tennis.scoreIdxs;
import static tennis.Tennis.scores;
import static tennis.Tennis.set;
import static tennis.Tennis.setCount;

import java.util.Random;
import java.util.Scanner;

public class Main {
	public static void main(String[] args) {
		Tennis.makeNewFile(); // 파일이 이미 있다면 내용을 비움
		Scanner sc = new Scanner(System.in);
		Random random = new Random(); 
		scoreBoard.put(1, new int[6]);
		scoreBoard.put(2, new int[6]);

		System.out.print("> 경기의 세트 수(3 or 5), 두 선수의 이름을 각각 입력해주세요 ? ");
		set = sc.nextInt();
		
		// 세트 수는 3 이나 5 이어야 함
		if (set != 3 && set != 5) {
			System.out.println("> 세트 수는 3세트와 5세트만 있습니다.");
			return;
		}

		// 선수이름 입력
		players[0] = sc.next();
		players[1] = sc.next();

		// 게임시작
		Game: while (true) {
			int winPlayer;

			// 게임한판
			while (true) {
				winPlayer = random.nextInt(2) + 1; // 1 or 2 이 이기는지지는지 여기서 결정
				int losePlayer = winPlayer == 2 ? 1 : 2;
				checkBoard(); // 게임배열의 인덱스가 배열크기를 초과했는지 확인

				// 이긴 사람이 40 이고 진 사람이 45 이면 진 사람의 점수를 40 으로 변경
				if (isForty(winPlayer) && Condition.isFortyfive(losePlayer)) {
					scoreIdxs[losePlayer - 1]--;
					scoreBoard.get(losePlayer)[curGame] = scores[scoreIdxs[losePlayer - 1] - 1];
				} else {
					pointWinner(winPlayer); // 이긴사람의 점수를 증가
				}

				// 이긴 사람이 45 이상이고 듀스가 아니라면 승수를 더하고 다음게임
				if (overFortyfive(winPlayer) && !isDeuce(winPlayer)) {
					Tennis.gameEnded(winPlayer, losePlayer);
					break;
				}

				// 점수판 출력 및 세트가 2점차로 끝났는지 확인
				dispScoreBoard();
			} // 안쪽 while
			
			// 한 세트가 끝났다면
			if (setEnded(winPlayer)) {
				saveScoreBoard();
				printSetResult(winPlayer);

				setCount++;
				
				// 3선2승 혹은 5선3승을 하면 
				if (Tennis.winMoreThanHalf(winPlayer)) {
					resetBoardAndScore(winPlayer);
					Tennis.saveGameResult();
					break Game; // 모든 게임을 종료
				}
			}
			System.out.println("> 엔터를 입력하면 다음게임을 시작합니다.");
			Tennis.keyBoardInput();
		} // 바깥 while
	}
}
```

**Tennis**

```java
package tennis;

import java.io.BufferedWriter;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map.Entry;

public class Tennis {
	static HashMap<Integer, int[]> scoreBoard = new HashMap<>();
	static int[] scores = { 0, 15, 30, 40, 45, 50 }; // 점수 배열을 방문할 인덱스 값
	static int[] scoreIdxs = { 1, 1 }; // { 1번 플레이어의 점수 인덱스 값, 2번 플레이어의 점수 인덱스 값 }
	static String[] players = new String[2]; // 선수 이름 배열
	static int set;
	static int curGame = 0; // 0 ~ 5 현재 게임의 인덱스
	static int[] setWinner = new int[2]; // 세트 당 게임 승리 수
	static ArrayList<Integer> totalSetScore = new ArrayList<Integer>();
	static int winInARow;
	static int setCount = 1;

	// 점수판을 출력
	static void dispScoreBoard() {
		System.out.println(Arrays.toString(setWinner));
		scoreBoard.forEach((k, v) -> System.out.println(players[k - 1] + " " + Arrays.toString(v)));
	}

	static void pointWinner(int winner) {
		scoreBoard.get(winner)[curGame] = scores[scoreIdxs[winner - 1]];
		scoreIdxs[winner - 1]++;
	}

	public static void resetBoardAndScore(int winPlayer) {
		for (int i = 0; i < 5; i++) {
			System.out.println("\t\t . \t\t ");
		}
		System.out.println("-".repeat(30));
		clearBoard();
		printGameResult();
		System.out.println("-".repeat(30));
	}

	// 게임배열을 텍스트파일로 저장
	public static void saveScoreBoard() {
		String path = "src\\tennis\\Game_Result.txt";

		try (BufferedWriter bw = new BufferedWriter(new FileWriter(path, true))) {
			Iterator<Entry<Integer, int[]>> entry = scoreBoard.entrySet().iterator();

			while (entry.hasNext()) {
				Entry<Integer, int[]> ir = entry.next();
				String line = players[ir.getKey() - 1] + " " + Arrays.toString(ir.getValue()) + "\n";
				bw.write(line);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 게임배열을 모두 비움
	public static void clearBoard() {
		curGame = 0;
		Arrays.fill(scoreBoard.get(1), 0);
		Arrays.fill(scoreBoard.get(2), 0);
	}

	// curGame 배열의 인덱스가 배열크기를 초과하면 게임배열 초기화
	static void checkBoard() {
		if (curGame >= scoreBoard.get(1).length) {
			saveScoreBoard();
			clearBoard();
		}
	}

	// 세트결과 저장
	static void saveGameResult(int winPlayer) {
		String path = "src\\tennis\\Game_Result.txt";

		try (BufferedWriter bw = new BufferedWriter(new FileWriter(path, true))) {
			bw.write("-".repeat(30) + "\n");
			bw.write(String.format(" < %d 세트 결과 > \n", setCount));
			bw.write("\n");
			bw.write(String.format("> %d 세트 승리자 : %s\n", setCount, players[winPlayer - 1]));
			bw.write("\n");

			int Agame = setWinner[0];
			int Bgame = setWinner[1];

			bw.write(String.format("%s가 총 이긴 게임 수 : %d\n", players[0], Agame));
			bw.write(String.format("%s가 총 이긴 게임 수 : %d\n", players[1], Bgame));
			bw.write("\n");
			bw.write("-".repeat(30) + "\n");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	static void printSetResult(int winPlayer) {
		System.out.println("-".repeat(30));
		System.out.printf(" < %d 세트 결과 > \n", setCount);
		scoreBoard.forEach((k, v) -> System.out.println(players[k - 1] + " " + Arrays.toString(v)));
		System.out.println();
		System.out.printf("> %d 세트 승리자 : %s\n", setCount, players[winPlayer - 1]);
		System.out.println();
		int Agame = setWinner[0];
		int Bgame = setWinner[1];

		System.out.printf("%s가 총 이긴 게임 수 : %d\n", players[0], Agame);
		System.out.printf("%s가 총 이긴 게임 수 : %d\n", players[1], Bgame);
		System.out.println();

		System.out.println("-".repeat(30));
		saveGameResult(winPlayer);
		totalSetScore.add(winPlayer);
		clearBoard();

		// 점수배열의 인덱스와 승수를 초기화
		Arrays.fill(scoreIdxs, 1);
		Arrays.fill(setWinner, 0);
	}

	private static void printGameResult() {
		System.out.println(" < 최종 게임 결과 > ");
		int Aset = 0;
		int Bset = 0;
		for (int i = 0; i < totalSetScore.size(); i++) {
			System.out.printf("> %d세트: " + players[totalSetScore.get(i) - 1] + "\n", (i + 1));
			if (totalSetScore.get(i) == 1) {
				Aset++;
			} else if (totalSetScore.get(i) == 2) {
				Bset++;
			}
		}
		System.out.printf("\n%s가 총 이긴 세트 수 : %d\n", players[0], Aset);
		System.out.printf("%s가 총 이긴 세트 수 : %d\n\n", players[1], Bset);
		System.out.println("҉ ٩(๑>ω<๑)۶҉\t\t( ✪ワ✪)ノʸᵉᵃʰᵎ");
		System.out.printf("%s 이(가) %d 세트의 테니스게임을 승리했습니다.\n", players[Aset > Bset ? 0 : 1], set);
		System.out.println("(◍’౪`◍)♡\t\t(^▽^)/ ʸᵉᔆᵎ");
	}

	// 최종 게임결과 저장
	public static void saveGameResult() {
		String path = "src\\tennis\\Game_Result.txt";

		try (BufferedWriter bw = new BufferedWriter(new FileWriter(path, true))) {
			int Aset = 0;
			int Bset = 0;

			bw.write("\n\n < 최종 게임 결과 > ");

			for (int i = 0; i < totalSetScore.size(); i++) {
				bw.write(String.format("\n> %d세트: " + players[totalSetScore.get(i) - 1], (i + 1)));
				if (totalSetScore.get(i) == 1) {
					Aset++;
				} else if (totalSetScore.get(i) == 2) {
					Bset++;
				}
			}
			bw.write(String.format("\n\n%s가 총 이긴 세트 수 : %d\n", players[0], Aset));
			bw.write(String.format("%s가 총 이긴 세트 수 : %d\n\n", players[1], Bset));
			bw.write("҉ ٩(๑>ω<๑)۶҉\t\t( ✪ワ✪)ノʸᵉᵃʰᵎ\n");
			bw.write(String.format("%s 이(가) %d 세트의 테니스게임을 승리했습니다.\n", players[Aset > Bset ? 0 : 1], set));
			bw.write("(◍’౪`◍)♡\t\t(^▽^)/ ʸᵉᔆᵎ");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public static boolean winMoreThanHalf(int winPlayer) {
		int half = set / 2 + 1;
		int setScore = (int) totalSetScore.stream().filter(i -> i == winPlayer).count();
		return setScore == half;
	}

	public static void gameEnded(int winPlayer, int losePlayer) {
		setWinner[winPlayer - 1]++;
		Arrays.fill(scoreIdxs, 1);
		dispScoreBoard();
		System.out.printf("> %s가 %s를  %d : %d 으로 이겼습니다.\n", players[winPlayer - 1], players[losePlayer - 1],
				scoreBoard.get(winPlayer)[curGame], scoreBoard.get(losePlayer)[curGame]);
		curGame++;
	}

	// 키보드 입력을 기다림
	public static void keyBoardInput() {
		try {
			System.in.read();
			System.in.skip(System.in.available());
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	public static void makeNewFile() {
		try {
			new FileWriter("src\\tennis\\Game_Result.txt");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}
```

**Condition**

```java
package tennis;

import static tennis.Tennis.curGame;
import static tennis.Tennis.scoreBoard;
import static tennis.Tennis.scoreIdxs;
import static tennis.Tennis.setWinner;

public interface Condition {
	
	// 플레이어의 현재점수가 40 이면 true 반환
	static boolean isForty(int player) {
		return scoreBoard.get(player)[curGame] == 40;
	}

	// 플레이어의 현재점수가 45 이면 true 반환
	static boolean isFortyfive(int player) {
		return scoreBoard.get(player)[curGame] == 45;
	}
	
	// 듀스이면 true 반환
	static boolean isDeuce(int winPlayer) {
		int losePlayer = winPlayer == 2 ? 1 : 2;
		return scoreIdxs[winPlayer - 1] - scoreIdxs[losePlayer - 1] < 2;
	}

	// 한 명이 6점 이상이고 이긴 사람과 진 사람의 승수가 2점이상 차이가 나면 true 반환
	static boolean setEnded(int winPlayer) {
		int losePlayer = winPlayer == 2 ? 1 : 2;
		return setWinner[winPlayer - 1] >= 6 && setWinner[winPlayer - 1] - setWinner[losePlayer - 1] >= 2;
	}

	// 플레이어의 현재점수가 45 를 넘으면 true 반환
	static boolean overFortyfive(int player) {
		return scoreBoard.get(player)[curGame] >= 45;
	}
}
```

