-- Generated from ChapterQuadraticFockEsa.lean — solution of BookProof.QuadFockEsa.hermCol_apply
import Mathlib
import Definitions.Def_ChapterQuadraticFockEsa
import Theorems.Thm_BookProof_QuadFockEsa_symm_equiv_hermBasisN
import Theorems.Thm_BookProof_FockSecondQuantization_opCol_apply
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
open BookProof.QuadFockEsa




open MvPolynomial BookProof.HermiteProductCore BookProof.HermiteProductBasis
open BookProof.HermiteBand BookProof.GradedBandSchur
open BookProof.FockSecondQuantization BookProof.NavierStokesFlow
open BookProof.HermiteGalerkin BookProof.FarisLavine
open BookProof.YangMillsHermite BookProof.FullQuadratic
open BookProof.NavierStokesFlow.DifferentialL2

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (e : ℕ ≃ (Fin d →₀ ℕ)) (T : Module.End ℂ (MvPolynomial (Fin d) ℂ))
    (k j : ℕ) :
    hermCol e T k j = (inner ℂ (hermiteMvLp (e j)) (pgLp (T (hpsi (e k)))) : ℂ) := by

  rw [hermCol, opCol_apply, CoreRep.coe_op, symm_equiv_hermBasisN, hermBasisN_apply]
