-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.littleGroup_conj
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterLittleGroup
open BookProof.ChapterLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.littleGroup_conj {A : Matrix (Fin 2) (Fin 2) ℂ} (hA : A.det = 1) {p q : Fin 4 → ℝ}
    (h : act A (hermOfMom p) = hermOfMom q) :
    littleGroup q = (fun B => A * B * A⁻¹) '' littleGroup p := by sorry
