import time
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
import random
import string

# Colombian first names (replace with your list)
first_names = [
    "Juan", "Maria", "Daniella", "Santiago", "Camila", "Alejandro", "Isabella", "Sebastian",
    "Valentina", "Nicolas", "Sofia", "David", "Gabriela", "Miguel", "Paula", "Andres",
    "Laura", "Mateo", "Natalia", "Esteban", "Sara", "Luis", "Adriana", "Carlos",
]

# Colombian last names (replace with your list)
last_names = [
    "Perez", "Rodriguez", "Gonzalez", "Sanchez", "Martinez", "Diaz", "Restrepo", "Gutierrez",
    "Montoya", "Zapata", "Castaño", "Ramírez", "Vargas", "Arias", "Moreno", "Marín",
    "Valencia", "Blanco", "Londoño", "Hernandez", "Osorio"", Reina", "Uribe",
]

reviews_list = [
    "¡Increíble! Las gafas superaron mis expectativas en cuanto a calidad y diseño. Además, llegaron mucho antes de lo previsto. Definitivamente, una compra excelente.",
    "Estoy muy satisfecho con mi compra. Las gafas son muy cómodas y se ven geniales. El envío fue súper rápido y el empaque estaba impecable. Repetiré sin duda.",
    "Las gafas son de primera calidad y el servicio fue excepcional. No puedo creer lo rápido que llegaron. Recomiendo esta tienda a todos mis amigos.",
    "Muy contento con la compra. Las gafas son exactamente como se describen y la entrega fue extremadamente rápida. ¡Un servicio de 10!",
    "Las gafas llegaron en perfecto estado y muy rápido. La calidad es excelente y el precio justo. Definitivamente volveré a comprar aquí.",
    "Sorprendido por la rapidez del envío y la calidad de las gafas. Son cómodas y elegantes. El proceso de compra fue muy sencillo. ¡Recomendado!",
    "Las gafas son maravillosas, superaron mis expectativas. Llegaron rapidísimo y el empaque estaba muy bien cuidado. Un servicio excelente.",
    "No puedo estar más feliz con mi compra. Las gafas son preciosas y la entrega fue ultra rápida. Definitivamente, volveré a comprar aquí.",
    "Las gafas son de una calidad impresionante y llegaron antes de lo esperado. La atención al cliente fue excepcional. Recomiendo esta tienda al 100%.",
    "Muy buena experiencia de compra. Las gafas son de alta calidad y llegaron muy rápido. Todo el proceso fue fácil y sin problemas. ¡Excelente!",
    "Las gafas que compré son fantásticas, se ven y se sienten muy bien. Además, llegaron mucho antes de lo esperado. Muy satisfecho con el servicio.",
    "Un servicio impecable y unas gafas de gran calidad. La entrega fue extremadamente rápida. Muy contento con mi compra y con la tienda en general.",
    "Las gafas llegaron en tiempo récord y la calidad es insuperable. El diseño es hermoso y son muy cómodas. Sin duda, una gran compra.",
    "La calidad de las gafas es excelente y la entrega fue súper rápida. Todo llegó en perfecto estado. Estoy muy feliz con mi compra y con el servicio.",
    "Muy satisfecho con las gafas. Llegaron rápido y la calidad es top. El empaque estaba muy bien hecho, lo que asegura que las gafas lleguen en perfectas condiciones.",
    "Las gafas son increíbles y el envío fue ultra rápido. El proceso de compra fue fácil y la atención al cliente, excelente. Muy recomendable.",
    "Compré unas gafas y llegaron antes de lo previsto. La calidad es magnífica y el precio es razonable. Definitivamente, volveré a comprar aquí.",
    "La calidad de las gafas es excepcional y el envío fue muy rápido. Estoy muy satisfecho con mi compra y con el servicio al cliente. ¡Gran experiencia de compra!",
    "Me encantan mis nuevas gafas. Son elegantes y muy cómodas. La entrega fue súper rápida y el empaque estaba muy bien hecho. ¡Muy recomendable!",
    "Las gafas son perfectas y llegaron mucho antes de lo que esperaba. La calidad es impresionante y el servicio al cliente muy atento. ¡Cinco estrellas sin duda!",
    "¡Excelente servicio! Las gafas son de muy buena calidad y el diseño es exactamente como se muestra en la página. Lo mejor de todo es que llegaron en tiempo récord. Definitivamente compraré aquí de nuevo.",
    "Estoy muy impresionado con mi compra. Las gafas no solo son modernas y cómodas, sino que también llegaron muchísimo más rápido de lo que esperaba. Un servicio impecable y productos de alta calidad. ¡Muy recomendado!",
    "La experiencia de compra fue fantástica. Las gafas que pedí son perfectas y la entrega fue sorprendentemente rápida. Es raro encontrar una tienda online tan eficiente y con productos tan buenos. ¡10/10!",
    "No puedo estar más feliz con mis nuevas gafas. La calidad es excepcional y la velocidad de entrega fue impresionante. Apenas unos días después de hacer el pedido ya las tenía en mis manos. Sin duda volveré a comprar aquí.",
    "Un servicio de primera categoría. Las gafas son exactamente lo que buscaba y la entrega fue increíblemente rápida. Recomiendo esta página a todos los que busquen calidad y eficiencia en sus compras online.",
    "Las gafas son espectaculares y llegaron mucho antes de lo previsto. El empaque también es muy bonito y seguro. Sin duda, una excelente compra que repetiré pronto.",
    "Muy satisfecho con mi compra. Las gafas son de alta calidad y el servicio al cliente fue excelente. Además, llegaron mucho más rápido de lo esperado. ¡Cinco estrellas!",
    "Compré unas gafas y llegaron en perfectas condiciones y en tiempo récord. La calidad es insuperable y el precio muy competitivo. Recomiendo esta tienda al 100%.",
    "La calidad de las gafas es impresionante y la entrega fue ultra rápida. No podría estar más contento con mi compra. Una tienda online altamente recomendable.",
    "Todo perfecto. Las gafas son hermosas y muy cómodas, además de que la entrega fue sorprendentemente rápida. ¡Gran experiencia de compra!",
    "Encantada con mi compra. Las gafas son de gran calidad y llegaron en un abrir y cerrar de ojos. Muy buena atención al cliente también. ¡Volveré a comprar aquí!",
    "Las gafas que compré son exactamente lo que esperaba y más. La entrega fue súper rápida y el producto vino bien empaquetado. Sin duda, una tienda confiable.",
    "Recibí mis gafas en tiempo récord y la calidad es excelente. La página es muy fácil de navegar y el proceso de compra fue muy sencillo. Muy satisfecho con todo.",
    "¡Maravilloso! Las gafas son preciosas y de alta calidad. Además, la entrega fue mucho más rápida de lo esperado. Una experiencia de compra inmejorable.",
    "No puedo estar más feliz con mis nuevas gafas. Son elegantes, cómodas y llegaron increíblemente rápido. Muy recomendable esta tienda online.",
    "Las gafas son tal y como se describen en la página, de excelente calidad. Además, llegaron mucho antes de lo esperado. Gran servicio y productos.",
    "Súper satisfecho con la compra. Las gafas son de una calidad increíble y la entrega fue extremadamente rápida. Definitivamente, una tienda confiable.",
    "Increíble servicio. Las gafas son exactamente lo que buscaba y llegaron en un tiempo récord. Muy contenta con mi compra y con la rapidez de la entrega.",
    "Las gafas que compré son fantásticas y la entrega fue rapidísima. Todo el proceso de compra fue sencillo y el servicio al cliente excelente. Muy recomendable.",
    "La calidad de las gafas es impresionante y el envío fue muy rápido. La tienda ofrece un excelente servicio y productos de alta calidad. ¡Muy contento con mi compra!",
    "Un servicio impecable. Las gafas son hermosas y muy cómodas. La entrega fue súper rápida y el empaque estaba muy bien cuidado. ¡Sin duda, repetiré mi compra!",
    "Muy impresionado con la rapidez del envío y la calidad de las gafas. Son elegantes, cómodas y llegaron en perfecto estado. Gran experiencia de compra.",
    "La tienda ofrece gafas de alta calidad y un servicio excepcional. La entrega fue extremadamente rápida y todo llegó en perfectas condiciones. Muy recomendable.",
    "Las gafas son maravillosas, superaron todas mis expectativas. Llegaron rapidísimo y en perfecto estado. Definitivamente volveré a comprar aquí.",
    "La calidad de las gafas es impresionante y el proceso de compra fue muy sencillo. La entrega fue súper rápida y el empaque estaba muy bien hecho. Muy satisfecho con todo.",
    "No puedo estar más contento con mi compra. Las gafas son elegantes y cómodas, y llegaron mucho antes de lo esperado. Excelente servicio y calidad.",
    "Las gafas llegaron en tiempo récord y la calidad es insuperable. El diseño es hermoso y son muy cómodas. Sin duda, una gran compra.",
    "La calidad de las gafas es excelente y la entrega fue súper rápida. Todo llegó en perfecto estado. Estoy muy feliz con mi compra y con el servicio.",
        "Las gafas llegaron muy rápido y son de excelente calidad. Estoy muy contento con mi compra.",
    "Muy satisfecho con la compra. Las gafas son elegantes y cómodas, y la entrega fue rapidísima.",
    "No puedo creer lo rápido que llegaron mis gafas. Además, son de una calidad impresionante.",
    "La experiencia de compra fue excelente. Las gafas son tal y como se describen y llegaron en tiempo récord.",
    "Las gafas son perfectas y llegaron antes de lo esperado. Un servicio muy eficiente y productos de alta calidad.",
    "Compré unas gafas y estoy encantado con la calidad. Además, llegaron en un abrir y cerrar de ojos.",
    "Las gafas son increíbles y la entrega fue extremadamente rápida. Muy recomendable.",
    "Estoy muy impresionado con la calidad de las gafas y la rapidez de la entrega. Un servicio excelente.",
    "Las gafas son exactamente lo que buscaba y llegaron mucho antes de lo previsto. Muy satisfecho.",
    "El proceso de compra fue muy sencillo y las gafas llegaron rápidamente. La calidad es insuperable.",
    "Las gafas llegaron en perfectas condiciones y mucho antes de lo esperado. Gran calidad y diseño.",
    "Muy contento con mi compra. Las gafas son de alta calidad y el envío fue súper rápido.",
    "Las gafas son fabulosas y la entrega fue increíblemente rápida. Sin duda, volveré a comprar aquí.",
    "La calidad de las gafas es impresionante y llegaron en tiempo récord. Muy satisfecho con el servicio.",
    "Un servicio de primera. Las gafas son hermosas y la entrega fue súper rápida. Muy recomendable.",
    "No puedo estar más feliz con mis nuevas gafas. La calidad es excelente y llegaron rapidísimo.",
    "Las gafas son espectaculares y llegaron en un tiempo récord. Muy satisfecho con la compra.",
    "La calidad de las gafas es insuperable y la entrega fue súper rápida. Gran experiencia de compra.",
    "Las gafas llegaron mucho antes de lo previsto y son de una calidad impresionante. Muy contento.",
    "Compré unas gafas y llegaron rapidísimo. La calidad es excelente y el precio muy competitivo.",
    "Las gafas son maravillosas y llegaron en tiempo récord. Muy satisfecho con el servicio.",
    "La calidad de las gafas es increíble y la entrega fue muy rápida. Sin duda, una excelente compra.",
    "No puedo estar más contento con mi compra. Las gafas son elegantes y llegaron rapidísimo.",
    "Las gafas son perfectas y llegaron antes de lo esperado. Un servicio excelente y productos de alta calidad.",
    "Estoy muy impresionado con la calidad de las gafas y la rapidez de la entrega. Muy recomendable.",
    "Las gafas son increíbles y llegaron en un tiempo récord. Muy satisfecho con la compra.",
    "Muy contento con la compra. Las gafas son de alta calidad y el envío fue súper rápido.",
    "Las gafas son fabulosas y la entrega fue increíblemente rápida. Sin duda, volveré a comprar aquí.",
    "La calidad de las gafas es impresionante y llegaron en tiempo récord. Muy satisfecho con el servicio.",
    "Un servicio de primera. Las gafas son hermosas y la entrega fue súper rápida. Muy recomendable.",
    "No puedo estar más feliz con mis nuevas gafas. La calidad es excelente y llegaron rapidísimo.",
    "Las gafas son espectaculares y llegaron en un tiempo récord. Muy satisfecho con la compra.",
    "La calidad de las gafas es insuperable y la entrega fue súper rápida. Gran experiencia de compra.",
    "Las gafas llegaron mucho antes de lo previsto y son de una calidad impresionante. Muy contento.",
    "Compré unas gafas y llegaron rapidísimo. La calidad es excelente y el precio muy competitivo.",
    "Las gafas son maravillosas y llegaron en tiempo récord. Muy satisfecho con el servicio.",
    "La calidad de las gafas es increíble y la entrega fue muy rápida. Sin duda, una excelente compra.",
    "No puedo estar más contento con mi compra. Las gafas son elegantes y llegaron rapidísimo.",
    "Las gafas son perfectas y llegaron antes de lo esperado. Un servicio excelente y productos de alta calidad.",
    "Estoy muy impresionado con la calidad de las gafas y la rapidez de la entrega. Muy recomendable.",
    "Las gafas son increíbles y llegaron en un tiempo récord. Muy satisfecho con la compra.",
    "Muy contento con la compra. Las gafas son de alta calidad y el envío fue súper rápido.",
    "Las gafas son fabulosas y la entrega fue increíblemente rápida. Sin duda, volveré a comprar aquí.",
    "La calidad de las gafas es impresionante y llegaron en tiempo récord. Muy satisfecho con el servicio.",
    "Un servicio de primera. Las gafas son hermosas y la entrega fue súper rápida. Muy recomendable.",
    "No puedo estar más feliz con mis nuevas gafas. La calidad es excelente y llegaron rapidísimo.",
    "Las gafas son espectaculares y llegaron en un tiempo récord. Muy satisfecho con la compra.",
    "La calidad de las gafas es insuperable y la entrega fue súper rápida. Gran experiencia de compra.",
    "Las gafas llegaron mucho antes de lo previsto y son de una calidad impresionante. Muy contento.",
    "Compré unas gafas y llegaron rapidísimo. La calidad es excelente y el"
]


# Configurar el navegador web
driver = webdriver.Chrome()
wait = WebDriverWait(driver, 20)

# Abrir la página web
driver.get("https://www.gafas360.co/products/ray-ban-23")

try:
    used_reviews = set()
    
    for _ in range(5):
        # Esperar a que aparezca el botón de escribir un comentario
        write_review_button = wait.until(EC.element_to_be_clickable((By.XPATH, '//button[contains(@class, "head-button") and contains(@class, "tt-write-reviews") and normalize-space(text())="Escriba un comentario"]')))
        write_review_button.click()

        # Esperar a que aparezca el formulario de comentario
        review_form = wait.until(EC.visibility_of_element_located((By.ID, "trustoo-allinone")))

        # Generate random Colombian name
        random_first_name = random.choice(first_names)
        random_last_name = random.choice(last_names)
        random_name = f"{random_first_name} {random_last_name}"
        # Generate random 3-digit number
        random_number = str(random.randint(100, 999))
    
        random_email = f"{random_first_name}{random_number}@example.com"

        # Ingresar nombre aleatorio
        name_field = review_form.find_element(By.CSS_SELECTOR, 'input[input-type="author"]')
        name_field.send_keys(random_name)

        # Ingresar correo electrónico aleatorio
        email_field = review_form.find_element(By.CSS_SELECTOR, 'input[input-type="author_email"]')
        email_field.send_keys(random_email)
        
        # Elegir una review aleatoria que no haya sido usada antes
        review_random = random.choice([review for review in reviews_list if review not in used_reviews])
        used_reviews.add(review_random)  # Agregar la review utilizada al conjunto de reviews usadas

        review_field = review_form.find_element(By.CSS_SELECTOR, 'textarea[input-type="content"]')
        review_field.send_keys(review_random)

        # Calificar con 5 estrellas
        star_rating = review_form.find_element(By.CSS_SELECTOR, '.star-item.nostar:nth-child(5)')
        # Calificar con 5 estrellas seleccionando todas las estrellas

        star_rating.click()
            

        # Enviar el formulario
        submit_button = review_form.find_element(By.CLASS_NAME, "form-submit")
        submit_button.click()
        
        time.sleep(1)
        
        # Esperar a que aparezca el botón "Continuar"
        continue_button = wait.until(EC.element_to_be_clickable((By.XPATH, '//div[@class="window-button"]//button[normalize-space(text())="Continuar"]')))
        continue_button.click()
        
        time.sleep(1)

except Exception as e:
    print(f"Error: {str(e)}")
