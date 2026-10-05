-- Generated from ChapterFockQuadraticEsa.lean — solution of BookProof.FockQuadratic.pairOp_symmetricOn
import Mathlib
import Definitions.Def_ChapterFockQuadraticEsa
import Theorems.Thm_BookProof_FockQuadratic_hopOp_pairing
open BookProof.FockQuadratic



open scoped ENNReal


open BookProof.FarisLavine BookProof.NavierStokesFlow BookProof.NavierStokesFlow.IkebeKato
open BookProof.NavierStokesFlow.LpNat BookProof.OperatorSeries

noncomputable section

variable {ι : Type*}

variable {ι : Type*}
variable {ω : ι → ℝ}

set_option maxHeartbeats 1000000 in
theorem solution (hω : ∀ i, 0 ≤ ω i) (g : ℂ) (P Q : Idx ι)
    (hPQ : deg P + deg Q ≤ 2) : SymmetricOn (maxDom (sig ω)) (pairOp hω g P Q hPQ) := by

  intro x y
  simp only [pairOp, LinearMap.add_apply, LinearMap.smul_apply,
    inner_add_left, inner_add_right, inner_smul_left, inner_smul_right]
  rw [hopOp_pairing hω hPQ (by omega) x y, hopOp_pairing hω (by omega : deg Q + deg P ≤ 2) hPQ x y]
  simp [RingHomCompTriple.comp_apply, RingHom.id_apply]
  ring
