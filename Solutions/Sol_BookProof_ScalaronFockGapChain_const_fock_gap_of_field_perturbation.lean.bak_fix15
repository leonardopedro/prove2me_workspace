-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.const_fock_gap_of_field_perturbation
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_isPosCol_shiftCol
import Theorems.Thm_BookProof_FockFieldPerturbation_fock_gap_of_field_perturbation_pos
open BookProof.ScalaronFockGapChain



noncomputable section


open BookProof.FockSecondQuantization BookProof.FockOneParticleGap
open BookProof.FockNumberPreservingGap BookProof.FockFieldPerturbation
open BookProof.FockCubicQuarticStability BookProof.FockCubicUnbounded
open BookProof.FockInteractionStability
open BookProof.FarisLavine BookProof.YangMillsFriedrichs BookProof.HermiteGalerkin
open BookProof.HermiteCore

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]

set_option maxHeartbeats 1000000 in
theorem solution (b : HilbertBasis ℕ ℂ F) {m : ℝ} (hm : 0 < m)
    {f : ℕ →₀ ℂ} (hf : 2 * l2norm f < m) {u : FockAlg} (h0 : u 0 = 0) :
    0 < m - 2 * l2norm f ∧
      (m - 2 * l2norm f) * ‖toLp u‖ ^ 2
        ≤ (inner ℂ (toLp u) (toLp (dGamma (opCol b (constOnePart b m)) u)) : ℂ).re
          + (inner ℂ (toLp u) (toLp (fieldVec f u)) : ℂ).re := fock_gap_of_field_perturbation_pos hm (const_isPosCol_shiftCol b m) hf h0
