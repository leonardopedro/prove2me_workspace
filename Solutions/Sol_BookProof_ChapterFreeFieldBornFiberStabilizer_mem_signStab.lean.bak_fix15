-- Generated from ChapterFreeFieldBornFiberStabilizer.lean — solution of BookProof.ChapterFreeFieldBornFiberStabilizer.mem_signStab
import Mathlib
import Definitions.Def_ChapterFreeFieldBornFiberStabilizer
open BookProof.ChapterFreeFieldBornFiberStabilizer



open MeasureTheory
open BookProof.ChapterFreeFieldBorn
open BookProof.ChapterFreeFieldBornQuotient
open BookProof.ChapterFreeFieldBornSignGauge
open BookProof.ChapterFreeFieldBornFiberCardGeneral
open BookProof.ChapterFreeFieldBornFiberBounds


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {x : EuclideanSpace ℝ (Fin n)} {b : Fin n → Bool} :
    b ∈ signStab x ↔ ∀ k, x k ≠ 0 → b k = true := by

      simp only [signStab, Finset.mem_filter, Finset.mem_univ, true_and, ne_eq];
      constructor <;> intro h <;> simp_all only [signFlip, WithLp.equiv_symm_apply];
      · intro k hk; replace h := congr_arg ( fun f => f k ) h; simp_all [ boolSign ] ;
        by_cases hb : b k = true
        · exact hb
        · have hbf : b k = false := by simpa using hb
          have hz0 : x.ofLp k = 0 := by linarith [h hbf]
          exact absurd hz0 hk;
      · ext k; by_cases hk : x.ofLp k = 0 <;> simp_all [ boolSign ] ;
