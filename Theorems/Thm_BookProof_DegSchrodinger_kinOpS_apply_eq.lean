-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.kinOpS_apply_eq
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterYangMillsHermite
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterA4
open BookProof.HermiteProductCore
open BookProof.StrichartzWave
open BookProof.DegSchrodinger

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs

noncomputable section


theorem BookProof.DegSchrodinger.kinOpS_apply_eq (S : Finset (Fin d)) (f : 𝓢(Vd d, ℂ)) (x : Vd d) :
    (kinOpS S f) x = -lapCS S (f : Vd d → ℂ) x := by sorry
