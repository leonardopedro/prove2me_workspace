-- Generated from ChapterSmComparisonEsa.lean — solution of BookProof.SmComparisonEsa.one_le_polyW_smPotPoly
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Theorems.Thm_BookProof_SmComparisonEsa_polyW_smPotPoly
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterYangMillsFriedrichs
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterDegKatoEsa
import Definitions.Def_ChapterHermiteGraphApprox
import Definitions.Def_ChapterSmFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
open BookProof.SmComparisonEsa




open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOneParticle

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (P : SmParams) {c0 : ℝ} (hc0 : 1 ≤ c0) (x : Vd 163) :
    1 ≤ polyW (smPotPoly P c0) x := by

  rw [polyW_smPotPoly]
  have h1 : (0 : ℝ) ≤ ∑ r : Fin 49, (polyW (smPhi P r) x) ^ 2 := by positivity
  have h2 : (0 : ℝ) ≤ ∑ m : Fin 40, (x (smCoord m)) ^ 2 := by positivity
  linarith
