-- Generated from ChapterQgOneParticleCcEsa.lean — solution of BookProof.QgOneParticleCc.sum_harmW_partLM
import Mathlib
import Definitions.Def_ChapterQgOneParticleCcEsa
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterFarisLavine
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterScalaronCoreEsa
import Definitions.Def_ChapterQgHermiteCore
import Definitions.Def_ChapterQgHermiteFriedrichs
import Definitions.Def_ChapterHermiteQuadraticEsa
import Definitions.Def_ChapterStoneBridge
import Definitions.Def_ChapterEsaClosureCore
import Definitions.Def_ChapterSirkTrotterKato
import Definitions.Def_ChapterDirectSumEsa
import Definitions.Def_ChapterQgHermiteOscillatorEsa
open BookProof.QgOneParticleCc




open MeasureTheory SchwartzMap Complex MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgHermiteOscillator BookProof.HermiteQuadraticEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.QgHermiteOscillator

noncomputable section

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F]
variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (n d : ℕ) (x : Vd (n * d)) :
    ∑ k : Fin n, harmW (partLM n d k x) = harmW x := by

  have hsq : ∑ k : Fin n, ‖partLM n d k x‖ ^ 2 = ‖x‖ ^ 2 := by
    simp only [norm_sq_eq_sum, partLM_apply]
    have h : ∑ ki : Fin n × Fin d, (x (finProdFinEquiv ki)) ^ 2
        = ∑ k : Fin n, ∑ i : Fin d, (x (finProdFinEquiv (k, i))) ^ 2 :=
      Fintype.sum_prod_type _
    rw [← h]
    exact Fintype.sum_equiv finProdFinEquiv _ _ (fun a => rfl)
  simp only [harmW, ← Finset.sum_div, hsq]
