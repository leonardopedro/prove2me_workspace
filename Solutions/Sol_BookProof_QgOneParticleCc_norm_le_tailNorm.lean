-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.norm_le_tailNorm
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {u : L2d d} {S : Set (Vd d)} {g : Vd d → ℝ}
    (hg : MemLp g 2 (volume : Measure (Vd d)))
    (h : ∀ᵐ z ∂(volume : Measure (Vd d)), ‖(u : Vd d → ℂ) z‖ ≤ ‖S.indicator g z‖) :
    ‖u‖ ≤ (eLpNorm (S.indicator g) 2 (volume : Measure (Vd d))).toReal := by

  rw [Lp.norm_def]
  exact ENNReal.toReal_mono ((eLpNorm_indicator_le g).trans_lt hg.2).ne (eLpNorm_mono_ae h)
