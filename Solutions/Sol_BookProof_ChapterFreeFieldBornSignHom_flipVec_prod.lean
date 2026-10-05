-- Generated from ChapterFreeFieldBornSignHom.lean — solution of BookProof.ChapterFreeFieldBornSignHom.flipVec_prod
import Mathlib
import Definitions.Def_ChapterFreeFieldBornSignHom
open BookProof.ChapterFreeFieldBornSignHom



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornSignAction


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (b : Fin n → Bool) :
    (∏ k, flipVec b k) = (-1 : ℝ) ^ flipCount b := by

  norm_num [Finset.prod_ite, flipVec]
  rfl
