-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.equiv_symm_pgLp
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_equiv_pgLp
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (p : MvPolynomial (Fin 163) ℂ) :
    (coreRepPoly 163).equiv.symm ⟨pgLp p, pgLp_mem_core p⟩ = p := by

  rw [← equiv_pgLp p, LinearEquiv.symm_apply_apply]
