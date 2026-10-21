-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.equiv_pgLp
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
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
    (coreRepPoly 163).equiv p = ⟨pgLp p, pgLp_mem_core p⟩ := Subtype.ext ((coreRepPoly 163).coe_equiv p)
