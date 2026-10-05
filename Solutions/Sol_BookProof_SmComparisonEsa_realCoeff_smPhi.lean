-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.realCoeff_smPhi
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
theorem solution (P : SmParams) (r : Fin 49) : RealCoeff (smPhi P r) := realCoeff_smFormPoly P _ _
