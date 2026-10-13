-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.ccHam_coeFn
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_kinOp_apply_eq
import Theorems.Thm_BookProof_QgOneParticleCc_kinCc_apply
import Theorems.Thm_BookProof_ScalaronEsa_mulCc_apply
import Theorems.Thm_BookProof_ScalaronEsa_opCc_apply
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (W : Vd d → ℝ) (hWs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) W)
    (f : ccSchwartz (Vd d)) :
    ((ccHam W hWs (ccEquiv (Vd d) f) : L2d d) : Vd d → ℂ)
      =ᵐ[volume] fun z => -lapC (fun y : Vd d => (f : 𝓢(Vd d, ℂ)) y) z
        + ((W z : ℝ) : ℂ) * (f : 𝓢(Vd d, ℂ)) z := by

  have h1 : ccHam W hWs (ccEquiv (Vd d) f)
      = (kinOp d (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d))
        + (mulCc W hWs f).toLp 2 (volume : Measure (Vd d)) := by
    simp only [ccHam, LinearMap.add_apply, kinCc_apply, opCc_apply]
  rw [h1]
  filter_upwards [Lp.coeFn_add ((kinOp d (f : 𝓢(Vd d, ℂ))).toLp 2 (volume : Measure (Vd d)))
      ((mulCc W hWs f).toLp 2 (volume : Measure (Vd d))),
    (kinOp d (f : 𝓢(Vd d, ℂ))).coeFn_toLp 2 (volume : Measure (Vd d)),
    (mulCc W hWs f).coeFn_toLp 2 (volume : Measure (Vd d))] with z hz h2 h3
  rw [hz, Pi.add_apply, h2, h3, kinOp_apply_eq, mulCc_apply]
