-- Generated from ChapterSmComparisonEsa.lean — theorem BookProof.SmComparisonEsa.polyW_smPotPoly
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
import Mathlib
import Definitions.Def_ChapterSmComparisonEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterSmHamiltonian
import Definitions.Def_ChapterSmOneParticle
open BookProof.HermiteProductCore
open BookProof.SmHamiltonian
open BookProof.SmOneParticle
open BookProof.SmComparisonEsa



open MeasureTheory MvPolynomial
open BookProof.FarisLavine BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.YangMillsFriedrichs
open BookProof.DegSchrodinger BookProof.DegKatoEsa BookProof.HermiteGraphApprox
open BookProof.SmOneParticle BookProof.SmHamiltonian BookProof.SmFarisLavine

noncomputable section

theorem BookProof.SmComparisonEsa.polyW_smPotPoly (P : SmParams) (c0 : ℝ) (x : Vd 163) :
    polyW (smPotPoly P c0) x
      = (∑ r : Fin 49, (polyW (smPhi P r) x) ^ 2)
        + (∑ m : Fin 40, (x (smCoord m)) ^ 2) + c0 := by sorry
