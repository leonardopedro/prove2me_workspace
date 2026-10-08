-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.kinOpS_apply_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStrichartzWave
open BookProof.HermiteProductCore
open BookProof.StrichartzWave
open BookProof.DegSchrodinger



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}


theorem BookProof.DegSchrodinger.kinOpS_apply_eq (S : Finset (Fin d)) (f : 𝓢(Vd d, ℂ)) (x : Vd d) :
    (kinOpS S f) x = -lapCS S (f : Vd d → ℂ) x := by sorry
