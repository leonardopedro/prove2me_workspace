-- Generated from ChapterScalaronHermiteEsa.lean — theorem BookProof.ScalaronHermiteEsa.moments_of_deficiency
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStarobinskyPotential
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Mathlib
import Definitions.Def_ChapterScalaronHermiteEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteCore
open BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator
open BookProof.ScalaronHermiteEsa



open MeasureTheory Complex MvPolynomial FourierTransform
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}


theorem BookProof.ScalaronHermiteEsa.moments_of_deficiency {W : Vd d → ℝ} (hWc : Continuous W) (hWb : ExpBounded W)
    {z : ℂ} {w : L2d d}
    (hw : ∀ v : polyGaussCore (d := d),
      (inner ℂ (potCore W hWc hWb v) (w : L2d d) : ℂ) = z * inner ℂ (v : L2d d) (w : L2d d))
    (p : MvPolynomial (Fin d) ℂ) :
    ∫ x : Vd d, pgFun p x * ((((W x : ℝ) : ℂ) - z) * (w : Vd d → ℂ) x) = 0 := by sorry
