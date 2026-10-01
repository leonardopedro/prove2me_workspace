-- Generated from ChapterYangMillsAbelianEsa.lean — solution of BookProof.YangMillsAbelianEsa.sum_ymMagVec_X
import Mathlib
import Definitions.Def_ChapterYangMillsAbelianEsa
open BookProof.YangMillsAbelianEsa




open Finset MvPolynomial
open BookProof.HermiteProductCore BookProof.YangMillsHermite
open BookProof.FarisLavine
open BookProof.NavierStokesFlow.DifferentialL2
open BookProof.HermiteRelative
open BookProof.FullQuadratic
open BookProof.StoneBridge BookProof.EsaClosure BookProof.ChapterStoneResolvent
open BookProof.HashimotoShiftInvert BookProof.HermiteGalerkin BookProof.YangMillsFriedrichs

noncomputable section

set_option maxHeartbeats 1000000 in
theorem solution (m : Fin 24) :
    ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • (X n : MvPolynomial (Fin 99) ℂ)
      = magPoly 0 (decodeSpace m) (decodeColor m) := by

  have hmag : magPoly 0 (decodeSpace m) (decodeColor m)
      = ∑ j : Fin 3, ∑ k : Fin 3, ((levi (decodeSpace m) j k : ℝ) : ℂ)
          • (X (idxD j k (decodeColor m)) : MvPolynomial (Fin 99) ℂ) := by
    refine Finset.sum_congr rfl fun j _ => Finset.sum_congr rfl fun k _ => ?_
    simp
  have hL : ∑ n : Fin 99, ((ymMagVec m n : ℝ) : ℂ) • (X n : MvPolynomial (Fin 99) ℂ)
      = ∑ n : Fin 99, ∑ j : Fin 3, ∑ k : Fin 3,
          ((if n = idxD j k (decodeColor m) then (levi (decodeSpace m) j k : ℝ) else 0 : ℝ) : ℂ)
            • (X n : MvPolynomial (Fin 99) ℂ) := by
    refine Finset.sum_congr rfl fun n _ => ?_
    rw [ymMagVec]
    push_cast
    rw [Finset.sum_smul]
    exact Finset.sum_congr rfl fun j _ => Finset.sum_smul
  rw [hL, hmag]
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun j _ => ?_
  rw [Finset.sum_comm]
  refine Finset.sum_congr rfl fun k _ => ?_
  rw [Finset.sum_eq_single (idxD j k (decodeColor m))]
  · simp
  · intro b _ hb
    simp [hb]
  · intro h
    exact absurd (Finset.mem_univ (idxD j k (decodeColor m))) h
