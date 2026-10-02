-- Generated from ChapterNavierStokesHermiteFarisLavine.lean — solution of BookProof.NavierStokesFlow.HermiteFarisLavine.conj_hFun_mul
import Mathlib
import Definitions.Def_ChapterNavierStokesHermiteFarisLavine
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.HermiteFarisLavine



open scoped ENNReal



open LpNat FarisLavine IkebeKato

variable {κ : ℝ}
variable {x : maxDom (oscSymbol κ)}

set_option maxHeartbeats 1000000 in
theorem solution (κ : ℝ) (X Y : ℕ → ℂ) (m : ℕ) :
    (starRingEnd ℂ) (hFun κ X m) * Y m
      = -Complex.I * shift2 (crossA κ X Y) m + Complex.I * crossB κ X Y m := by

  rcases Nat.lt_or_ge m 2 with hm | hm
  · interval_cases m <;>
      simp [hFun, crossB, shift2, Complex.ext_iff] <;>
      constructor <;> ring
  · obtain ⟨k, rfl⟩ : ∃ k, m = k + 2 := ⟨m - 2, by omega⟩
    simp only [hFun, crossA, crossB, shift2_add_two, map_mul, Complex.conj_I,
      Complex.conj_ofReal, map_sub]
    ring
