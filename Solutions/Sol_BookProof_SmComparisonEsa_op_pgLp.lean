-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.op_pgLp
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_equiv_symm_pgLp
import Theorems.Thm_BookProof_YangMillsHermite_CoreRep_coe_op
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (T : Module.End ℂ (MvPolynomial (Fin 163) ℂ)) (p : MvPolynomial (Fin 163) ℂ) :
    (coreRepPoly 163).op T ⟨pgLp p, pgLp_mem_core p⟩ = ⟨pgLp (T p), pgLp_mem_core _⟩ := by

  refine Subtype.ext ?_
  rw [CoreRep.coe_op, equiv_symm_pgLp]
