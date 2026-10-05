-- Generated from ChapterScalaronFockGapChain.lean — solution of BookProof.ScalaronFockGapChain.scalaron_fock_cubic_quartic_bounded_below
import Mathlib
import Definitions.Def_ChapterScalaronFockGapChain
import Theorems.Thm_BookProof_ScalaronFockGapChain_const_fock_cubic_quartic_bounded_below
import Theorems.Thm_BookProof_ScalaronFockGapChain_scalaronMass_pos
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
theorem solution {alpha : ℝ} (halpha : 0 < alpha)
    (S : Finset ℕ) (lam : ℝ) (u : FockAlg) :
    -(S.card * (2 * lam ^ 2 + (2 * lam ^ 2 + 1 / 2 - scalaronMass alpha) ^ 2 / 2))
        * ‖toLp u‖ ^ 2
      ≤ (inner ℂ (toLp u)
            (toLp (dGamma (opCol hermiteBasis (scalaronOnePart alpha)) u)) : ℂ).re
        + ∑ k ∈ S, (lam * (inner ℂ (toLp u) (toLp (cubeA k u)) : ℂ).re
            + (inner ℂ (toLp u) (toLp (quartA k u)) : ℂ).re) := const_fock_cubic_quartic_bounded_below hermiteBasis (scalaronMass_pos halpha) S lam u
