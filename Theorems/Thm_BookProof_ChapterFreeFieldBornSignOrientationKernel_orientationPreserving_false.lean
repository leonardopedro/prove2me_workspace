-- Generated from ChapterFreeFieldBornSignOrientationKernel.lean — theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_false
import Definitions.Def_ChapterFreeFieldBornSignHom
import Definitions.Def_ChapterFreeFieldBornSignMatrix
import Definitions.Def_ChapterFreeFieldBornSignOrientation
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignOrientationKernel
open BookProof.ChapterFreeFieldBornSignOrientationKernel

variable {n : ℕ}


open BookProof.ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignMatrix
open BookProof.ChapterFreeFieldBornSignOrientation



theorem BookProof.ChapterFreeFieldBornSignOrientationKernel.orientationPreserving_false :
    flipMatrix (fun _ => false : Fin n → Bool) ∈
      Matrix.specialOrthogonalGroup (Fin n) ℝ := by sorry
