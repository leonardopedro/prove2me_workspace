-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.qgNParticleCc_esa
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Theorems.Thm_BookProof_QgOneParticleCc_qgOneParticleCc_esa
import Theorems.Thm_BookProof_QgOneParticleCc_ccHam_congr
import Theorems.Thm_BookProof_QgOneParticleCc_nParticleW_harm_add
import Theorems.Thm_BookProof_QgOneParticleCc_abs_nParticleW_le
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterFarisLavineCore
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterQgHermiteOscillatorEsa
import Definitions.Def_ChapterScalaronCoreEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteOscillator
open BookProof.ScalaronEsa

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution {V : Vd d → ℝ} {a b : ℝ}
    (hVs : ContDiff ℝ ((⊤ : ℕ∞) : WithTop ℕ∞) V) (ha : 0 ≤ a) (ha1 : a < 1) (hb : 0 ≤ b)
    (hV : ∀ y, |V y| ≤ a * harmW y + b) (n : ℕ) :
    EssentiallySelfAdjointOn (ccDomain (Vd (n * d)))
      (ccHam (nParticleW (fun y => harmW y + V y) n)
        (contDiff_nParticleW ((contDiff_harmW d).add hVs) n)) := by

  have hfun := nParticleW_harm_add V n
  have hone := qgOneParticleCc_esa (d := n * d) (V := nParticleW V n) (a := a) (b := n * b)
    (contDiff_nParticleW hVs n) ha ha1 (by positivity) (abs_nParticleW_le hV n)
  rw [ccHam_congr hfun (contDiff_nParticleW ((contDiff_harmW d).add hVs) n)
    ((contDiff_harmW (n * d)).add (contDiff_nParticleW hVs n))]
  exact hone
