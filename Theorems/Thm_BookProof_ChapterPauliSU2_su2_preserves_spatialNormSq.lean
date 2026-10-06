-- Generated from ChapterPauliSU2.lean — theorem BookProof.ChapterPauliSU2.su2_preserves_spatialNormSq
import Mathlib
import Definitions.Def_ChapterPauliSU2
import Definitions.Def_ChapterPauliLorentz
open BookProof.ChapterPauliLorentz
open BookProof.ChapterPauliSU2


open Matrix
open scoped BigOperators


open BookProof.ChapterPauliLorentz

theorem BookProof.ChapterPauliSU2.su2_preserves_spatialNormSq {T : Matrix (Fin 2) (Fin 2) ℂ}
    (hU : Tᴴ * T = 1) (hT : T.det = 1) (x : Fin 4 → ℝ) :
    spatialNormSq (vecOfMat (spinorAction T (hermMat x))) = spatialNormSq x := by sorry
