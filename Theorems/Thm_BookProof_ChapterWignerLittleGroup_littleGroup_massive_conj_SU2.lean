-- Generated from ChapterWignerLittleGroup.lean — theorem BookProof.ChapterWignerLittleGroup.littleGroup_massive_conj_SU2
import Mathlib
import Definitions.Def_ChapterWignerLittleGroup
import Definitions.Def_ChapterLittleGroup
open BookProof.ChapterLittleGroup
open BookProof.ChapterWignerLittleGroup


open Matrix Complex

theorem BookProof.ChapterWignerLittleGroup.littleGroup_massive_conj_SU2 {m : ℝ} (hm : 0 < m) (p : Fin 4 → ℝ) (hp0 : 0 < p 0)
    (hshell : p 0 ^ 2 - p 1 ^ 2 - p 2 ^ 2 - p 3 ^ 2 = m ^ 2) :
    ∃ A : Matrix (Fin 2) (Fin 2) ℂ, A.det = 1 ∧
      littleGroup p = (fun B => A * B * A⁻¹) '' SU2 := by sorry
