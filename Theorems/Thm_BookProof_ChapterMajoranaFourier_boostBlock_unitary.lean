-- Generated from ChapterMajoranaFourier.lean — theorem BookProof.ChapterMajoranaFourier.boostBlock_unitary
import Definitions.Def_ChapterA3
import Mathlib
import Definitions.Def_ChapterMajoranaFourier
open BookProof.ChapterMajoranaFourier


open Matrix


open BookProof.ChapterA3

theorem BookProof.ChapterMajoranaFourier.boostBlock_unitary {A : Matrix (Fin 4) (Fin 4) ℂ} (hA : Aᴴ = A)
    (hA2 : A * A = 1) {c s : ℝ} (hcs : c ^ 2 + s ^ 2 = 1) :
    (boostBlock c s A)ᴴ * boostBlock c s A = 1 := by sorry
