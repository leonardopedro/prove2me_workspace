-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.dcoord_ofReal
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u : Vd d → ℝ} (hu : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) u) (j : Fin d)
    (x : Vd d) :
    dcoord j (fun y => ((u y : ℝ) : ℂ)) x = ((fderiv ℝ u x (kinDir d j) : ℝ) : ℂ) := by

  have hdiff : DifferentiableAt ℝ u x := (hu.differentiable (by simp)).differentiableAt
  have h : HasFDerivAt (fun y => ((u y : ℝ) : ℂ))
      (Complex.ofRealCLM.comp (fderiv ℝ u x)) x :=
    Complex.ofRealCLM.hasFDerivAt.comp x hdiff.hasFDerivAt
  simp [dcoord, h.fderiv]
