-- Generated from ChapterHermiteQuadraticEsa.lean — theorem BookProof.HermiteQuadraticEsa.scaledHarmonic_essentiallySelfAdjoint
import Mathlib
import Definitions.Def_ChapterHermiteQuadraticEsa
open BookProof.HermiteQuadraticEsa














open MeasureTheory Complex MvPolynomial
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.FarisLavine BookProof.Starobinsky
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

variable {d : ℕ}

theorem BookProof.HermiteQuadraticEsa.scaledHarmonic_essentiallySelfAdjoint {lam : ℝ} (h0 : 0 < lam) (h2 : lam < 2)
    (hsc : Continuous fun x : Vd d => lam * harmW x)
    (hsb : ExpBounded fun x : Vd d => lam * harmW x) :
    EssentiallySelfAdjointOn (polyGaussCore (d := d))
      (hamCore (fun x : Vd d => lam * harmW x) hsc hsb) := by sorry
