-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.kinCcS_symmetricOn
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterStrichartzWave
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa
open BookProof.StrichartzWave
open BookProof.DegSchrodinger



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}


theorem BookProof.DegSchrodinger.kinCcS_symmetricOn (S : Finset (Fin d)) : SymmetricOn (ccDomain (Vd d)) (kinCcS S) := by sorry
