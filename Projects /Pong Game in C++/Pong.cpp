#include "Bat.h"
#include "Ball.h"
#include <sstream>
#include <cstdlib>
#include <SFML/Graphics.hpp>

using namespace sf;

int main()
{
	// Create a video mode object
	VideoMode vm(1920, 1080);

	// Create and open a window for the game
	RenderWindow window(vm, "Pong", Style::Fullscreen);

	// create the scores and lives
	int scoreLeft = 0;
	int livesLeft = 5;

	int scoreRight = 0;
	int livesRight = 5;

	// Create bats
	Bat batRight(1920 - 50, 1080 / 2);
	Bat batLeft(20, 1080 / 2);

	// Create a ball
	Ball ball(1920 / 2, 0);

	// Create a Text object called HUD
	Text hudLeft;
	Text hudRight;

	// Add a new font
	Font font;
	font.loadFromFile("fonts/GingiesBubble-jEdZM.otf");
	hudLeft.setFont(font);
	hudRight.setFont(font);
	hudLeft.setCharacterSize(75);
	hudRight.setCharacterSize(75);
	hudLeft.setFillColor(Color::White);
	hudRight.setFillColor(Color::White);
	hudLeft.setPosition(20, 20);
	hudRight.setPosition(1300, 20);

	// Here is our clock for timing everything
	Clock clock;

	// check if the game is running
	bool paused = true;

	// Control the player input
	bool acceptInput = false;

	// message for start and end/reset screens
	Text messageText;
	messageText.setFont(font);
	messageText.setString("Press Enter to start!");
	messageText.setCharacterSize(75);
	messageText.setFillColor(Color::White);

	// Position the text
	FloatRect textRect = messageText.getLocalBounds();

	messageText.setOrigin(textRect.left +
		textRect.width / 2.0f,
		textRect.top +
		textRect.height / 2.0f);

	messageText.setPosition(1920 / 2.0f, 1080 / 2.0f);

	Text subMessageText;
	subMessageText.setFont(font);
	subMessageText.setString(" ");
	subMessageText.setCharacterSize(50);
	subMessageText.setFillColor(Color::White);

	// Position the text
	FloatRect textRect2 = subMessageText.getLocalBounds();

	subMessageText.setOrigin(textRect2.left +
		textRect2.width / 2.0f,
		textRect2.top +
		textRect2.height / 2.0f);

	subMessageText.setPosition(1920 / 2.0f, (1080 / 2.0f) + 100);


	while (window.isOpen())
	{
		/*
		Handle the player input
		*********************************************************************
		*********************************************************************
		*********************************************************************
		*/

		Event event;
		while (window.pollEvent(event))
		{
			if (event.type == Event::KeyReleased && !paused)
			{
				// Listen for key presses
				acceptInput = true;
			}

		}

		// Handle the player quitting
		if (Keyboard::isKeyPressed(Keyboard::Escape))
		{
			window.close();
		}

		// Start the game
		if (Keyboard::isKeyPressed(Keyboard::Return))
		{
			paused = false;

			// Reset the lives and the score
			scoreRight = 0;
			livesRight = 5;
			scoreLeft = 0;
			livesLeft = 5;

			acceptInput = true;

		}

		// Make sure we are accepting input
		if (acceptInput)
		{
			// Handle the pressing and releasing of the arrow keys for the right bat
			if (Keyboard::isKeyPressed(Keyboard::Up))
			{
				batRight.moveUp();

			}
			else
			{
				batRight.stopUp();
			}

			if (Keyboard::isKeyPressed(Keyboard::Down))
			{
				batRight.moveDown();

			}
			else
			{
				batRight.stopDown();
			}

			if (Keyboard::isKeyPressed(Keyboard::Left))
			{
				batRight.moveLeftArrow();

			}
			else
			{
				batRight.stopLeftArrow();
			}

			if (Keyboard::isKeyPressed(Keyboard::Right))
			{
				batRight.moveRightArrow();

			}
			else
			{
				batRight.stopRightArrow();
			}

			// Handle the pressing and releasing of the "awsd" keys for the left bat
			if (Keyboard::isKeyPressed(Keyboard::W))
			{
				batLeft.moveUp();

			}
			else
			{
				batLeft.stopUp();
			}

			if (Keyboard::isKeyPressed(Keyboard::S))
			{
				batLeft.moveDown();

			}
			else
			{
				batLeft.stopDown();
			}

			if (Keyboard::isKeyPressed(Keyboard::A))
			{
				batLeft.moveLeftKey();

			}
			else
			{
				batLeft.stopLeftKey();
			}

			if (Keyboard::isKeyPressed(Keyboard::D))
			{
				batLeft.moveRightKey();

			}
			else
			{
				batLeft.stopRightKey();
			}

			/*
			Update the bat, the ball and the HUD
			*********************************************************************
			*********************************************************************
			*********************************************************************
			*/

			// Update the delta time
			Time dt = clock.restart();
			batRight.update(dt);
			batLeft.update(dt);
			ball.update(dt);
			// Update the HUD text
			std::stringstream sl;
			std::stringstream sr;

			sl << "Score:" << scoreLeft << "    Lives:" << livesLeft;
			sr << "Score:" << scoreRight << "    Lives:" << livesRight;

			hudLeft.setString(sl.str());
			hudRight.setString(sr.str());

			// Handle ball hitting the right wall
			if (ball.getPosition().left + 50 > window.getSize().x)
			{
				// reverse the ball direction
				ball.reboundRight();

				// Remove a life
				livesRight--;

			}

			// Handle ball hitting the left wall
			if (ball.getPosition().left < 0)
			{
				// reverse the ball direction
				ball.reboundRight();

				// Remove a life
				livesLeft--;

			}

			// Handle ball hitting sides (top and bottom)
			if (ball.getPosition().top < 0 ||
				ball.getPosition().top + 50 > window.getSize().y)
			{
				ball.reboundSides();
			}

			// ball hits the right bat
			if (ball.getPosition().intersects(batRight.getPosition()))
			{
				// Hit detected so reverse the ball and score a point
				ball.reboundBatOrLeft();

				// add a point to the right hud bc the right player hit it.
				scoreRight++;

				// added a rewards system for when the user gets to 10 points
				if (scoreRight == 10)
				{
					livesRight++;
				}
			}

			// ball hits the left bat
			if (ball.getPosition().intersects(batLeft.getPosition()))
			{

				// Hit detected so reverse the ball and score a point
				ball.reboundBatOrLeft();

				// add a point to the left hud bc the left player hit it.
				scoreLeft++;

				// added rewards system when the user gets to 10 points
				if (scoreLeft == 10)
				{
					livesLeft++;
				}
			}
		}

		if (!paused)
		{
			if (livesLeft < 1 || livesRight < 1) {
				// reset the score
				scoreLeft = 0;
				scoreRight = 0;

				// reset the lives
				livesLeft = 5;
				livesRight = 5;

				// Pause the game
				paused = true;
				acceptInput = false;

				messageText.setString("Out of lives!!");
				subMessageText.setString("Press Enter to restart!");

				//Reposition the text based on its new size
				FloatRect textRect = messageText.getLocalBounds();
				messageText.setOrigin(textRect.left +
					textRect.width / 2.0f,
					textRect.top +
					textRect.height / 2.0f);

				messageText.setPosition(1920 / 2.0f, 1080 / 2.0f);

				// Position the text
				FloatRect textRect2 = subMessageText.getLocalBounds();

				subMessageText.setOrigin(textRect2.left +
					textRect2.width / 2.0f,
					textRect2.top +
					textRect2.height / 2.0f);

				subMessageText.setPosition(1920 / 2.0f, (1080 / 2.0f) + 100);
			}
		}
		
		/*
		Draw the bat, the ball and the HUD
		*********************************************************************
		*********************************************************************
		*********************************************************************
		*/
		window.clear();
		window.draw(hudLeft);
		window.draw(hudRight);
		window.draw(batRight.getShape());
		window.draw(batLeft.getShape());
		window.draw(ball.getSprite());

		if (paused)
		{
			// Draw our message
			window.draw(messageText);
			window.draw(subMessageText);
		}

		window.display();
	}

	return 0;
}
