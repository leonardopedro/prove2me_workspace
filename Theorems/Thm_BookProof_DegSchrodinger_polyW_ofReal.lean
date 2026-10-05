-- Generated from ChapterDegSchrodingerCore.lean — theorem BookProof.DegSchrodinger.polyW_ofReal
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterHermiteProductBasis
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterYangMillsHermite
open BookProof.HermiteProductCore
open BookProof.QgHermiteFriedrichs
open BookProof.YangMillsHermite
open BookProof.DegSchrodinger

variable {d : ℕ}



open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section


theorem BookProof.DegSchrodinger.polyW_ofReal {q : MvPolynomial (Fin d) ℂ} (hq : RealCoeff q) (x : Vd d) :
    ((polyW q x : ℝ) : ℂ) = MvPolynomial.eval (fun i => ((x i : ℝ) : ℂ)) q := by sorry
