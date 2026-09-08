-- Generated from ChapterNavierStokesDeficiency.lean — solution of BookProof.NavierStokesFlow.DiagonalEsa.diagOp_not_bounded
import Mathlib
import Definitions.Def_ChapterNavierStokesDeficiency
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_diagOp_basis
import Theorems.Thm_BookProof_NavierStokesFlow_DiagonalEsa_norm_basis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiagonalEsa










open scoped ENNReal











open LpNat





























open LpNat

set_option maxHeartbeats 1000000 in
theorem solution (c : ℕ → ℝ) (hc : ∀ C : ℝ, ∃ n, C < |c n|) :
    ¬ ∃ C : ℝ, ∀ f : lpFiniteModes ℕ, ‖diagOp c f‖ ≤ C * ‖f‖ := by

  rintro ⟨C, hC⟩
  obtain ⟨n, hn⟩ := hc C
  have hb := hC (basis n)
  rw [diagOp_basis, norm_smul, norm_basis] at hb
  have hle : |c n| ≤ C := by simpa using hb
  exact absurd hn (not_lt.mpr hle)
