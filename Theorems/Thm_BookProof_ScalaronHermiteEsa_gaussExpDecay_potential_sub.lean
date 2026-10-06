-- Generated from ChapterScalaronHermiteEsa.lean — theorem BookProof.ScalaronHermiteEsa.gaussExpDecay_potential_sub
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.ScalaronHermiteEsa

variable {d : ℕ}



open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section


theorem BookProof.ScalaronHermiteEsa.gaussExpDecay_potential_sub {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    (z : ℂ) (w : L2d d) :
    GaussExpDecay (fun x : Vd d => (((W x : ℝ) : ℂ) - z) * (w : Vd d → ℂ) x) := by sorry
