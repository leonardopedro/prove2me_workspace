-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.dcoord_add
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_differentiableAt_of_contDiffTop
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
theorem solution {u v : Vd d → ℂ} (hu : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) u)
    (hv : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) v) (j : Fin d) :
    dcoord j (fun y => u y + v y) = fun x => dcoord j u x + dcoord j v x := by

  funext x
  simp only [dcoord]
  have h := ((differentiableAt_of_contDiffTop hu x).hasFDerivAt.add
    (differentiableAt_of_contDiffTop hv x).hasFDerivAt).fderiv
  change (fderiv ℝ (u + v) x) (kinDir d j) = _
  rw [h]
  simp
