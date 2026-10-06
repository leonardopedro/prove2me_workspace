-- Generated from ChapterNavierStokesAffineFiberEsa.lean — solution of BookProof.NavierStokesFlow.AffineFiber.commForm_add
import Mathlib
import Definitions.Def_ChapterNavierStokesAffineFiberEsa
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.AffineFiber



open scoped ENNReal



open LpNat BookProof.FarisLavine IkebeKato HermiteFarisLavine ShiftHamiltonian

variable {ι : Type*}

variable {ι : Type*}
variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] {D : Submodule ℂ F}

set_option maxHeartbeats 1000000 in
theorem solution (H₁ H₂ N : D →ₗ[ℂ] F) (x : D) :
    commForm (H₁ + H₂) N x = commForm H₁ N x + commForm H₂ N x := by

  simp only [commForm, LinearMap.add_apply, inner_add_left, inner_add_right]
  have : Complex.I * (inner ℂ (H₁ x) (N x) + inner ℂ (H₂ x) (N x)
      - (inner ℂ (N x) (H₁ x) + inner ℂ (N x) (H₂ x)))
      = Complex.I * (inner ℂ (H₁ x) (N x) - inner ℂ (N x) (H₁ x))
        + Complex.I * (inner ℂ (H₂ x) (N x) - inner ℂ (N x) (H₂ x)) := by ring
  rw [this, Complex.add_re]
