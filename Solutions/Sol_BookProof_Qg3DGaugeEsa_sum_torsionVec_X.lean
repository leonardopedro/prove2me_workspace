-- Generated from ChapterQg3DGaugeEsa.lean — solution of BookProof.Qg3DGaugeEsa.sum_torsionVec_X
import Mathlib
import Definitions.Def_ChapterQg3DGaugeEsa
import Theorems.Thm_BookProof_Qg3DGaugeEsa_sum_single_X
open BookProof.Qg3DGaugeEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.QuantumGravity3DGauge
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent

noncomputable section

set_option maxHeartbeats 1000000 in
 intro hc
    exact absurd (Finset.mem_univ c) hc

theorem solution (m : Fin 64) :
    ∑ i : Fin 84, ((torsionVec m i : ℝ) : ℂ) • (X :=
   i : MvPolynomial (Fin 84) ℂ)
        = torsionP m := by
    have hsplit : ∀ i : Fin 84, ((torsionVec m i : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
        = ((if i = torsionIdx1 m then (1 : ℝ) else 0 : ℝ) : ℂ) • (X i : MvPolynomial (Fin 84) ℂ)
          - ((if i = torsionIdx2 m then (1 : ℝ) else 0 : ℝ) : ℂ)
              • (X i : MvPolynomial (Fin 84) ℂ) := by
      intro i
      rw [← sub_smul]
      congr 1
      simp [torsionVec]
    rw [Finset.sum_congr rfl fun i _ => hsplit i, Finset.sum
