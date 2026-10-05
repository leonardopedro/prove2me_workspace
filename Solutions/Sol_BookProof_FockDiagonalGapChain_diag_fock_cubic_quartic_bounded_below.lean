-- Generated from ChapterFockDiagonalGapChain.lean — solution of BookProof.FockDiagonalGapChain.diag_fock_cubic_quartic_bounded_below
import Mathlib
import Definitions.Def_ChapterFockDiagonalGapChain
import Theorems.Thm_BookProof_FockDiagonalGapChain_diag_isPosCol_shiftCol
import Theorems.Thm_BookProof_FockCubicQuarticStability_dGamma_multiMode_cubic_quartic_bounded_below
open BookProof.FockDiagonalGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore BookProof.ScalaronFockGapChain
open Module


variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) (w : ℕ → ℝ) {m : ℝ}
    (hm : 0 < m) (hw : ∀ k, m ≤ w k) (S : Finset ℕ) (lam : ℝ) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - m) ^ 2 / 2)) * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (diagOnePart b w)) u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := dGamma_multiMode_cubic_quartic_bounded_below S hm (diag_isPosCol_shiftCol b w hw) u
