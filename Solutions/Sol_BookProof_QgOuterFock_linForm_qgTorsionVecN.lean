-- Generated from ChapterQgOuterFockEsa.lean — solution of BookProof.QgOuterFock.linForm_qgTorsionVecN
import Mathlib
import Definitions.Def_ChapterQgOuterFockEsa
import Theorems.Thm_BookProof_QgOuterFock_partOf_pcoord
import Theorems.Thm_BookProof_QgOuterFock_modeOf_pcoord
import Theorems.Thm_BookProof_QgOuterFock_sum_reindex_particles
import Theorems.Thm_BookProof_QgOuterFock_sum_single_block
open BookProof.QgOuterFock




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.Qg3DGaugeEsa
open BookProof.QgHermiteOscillator
open BookProof.DirectSumEsa
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution {n : ℕ} (p : Fin n) (m : Fin 64) :
    linForm (qgTorsionVecN n (p, m))
      = X (pcoord p (torsionIdx1 m)) - X (pcoord p (torsionIdx2 m)) := by

  classical
  rw [linForm, sum_reindex_particles, Finset.sum_eq_single p]
  · have hsplit : ∀ i : Fin 84, ((qgTorsionVecN n (p, m) (pcoord p i) : ℝ) : ℂ)
        • (X (pcoord p i) : MvPolynomial (Fin (n * 84)) ℂ)
        = ((if i = torsionIdx1 m then (1 : ℝ) else 0 : ℝ) : ℂ) • X (pcoord p i)
          - ((if i = torsionIdx2 m then (1 : ℝ) else 0 : ℝ) : ℂ) • X (pcoord p i) := by
      intro i
      have hcoef : qgTorsionVecN n (p, m) (pcoord p i) = torsionVec m i := by
        simp [qgTorsionVecN]
      rw [hcoef, ← sub_smul]
      congr 1
      simp [torsionVec]
    rw [Finset.sum_congr rfl fun i _ => hsplit i, Finset.sum_sub_distrib, sum_single_block,
      sum_single_block]
  · intro q _ hq
    refine Finset.sum_eq_zero fun i _ => ?_
    have hcoef : qgTorsionVecN n (p, m) (pcoord q i) = 0 := by
      simp [qgTorsionVecN, hq]
    rw [hcoef]
    simp
  · intro hp
    exact absurd (Finset.mem_univ p) hp
