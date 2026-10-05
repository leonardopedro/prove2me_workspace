-- Generated from ChapterDegSchrodingerCore.lean — solution of BookProof.DegSchrodinger.abs_coord_le_norm
import Mathlib
import Definitions.Def_ChapterDegSchrodingerCore
open BookProof.DegSchrodinger




open MeasureTheory SchwartzMap MvPolynomial
open BookProof.FarisLavine BookProof.StrichartzWave BookProof.ScalaronEsa
open BookProof.HermiteProductCore BookProof.QgHermiteCore BookProof.QgHermiteFriedrichs
open BookProof.QgOneParticleCc BookProof.YangMillsHermite BookProof.HermiteProductBasis

noncomputable section

variable {d : ℕ}

variable {d : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (x : Vd d) (i : Fin d) : |x i| ≤ ‖x‖ := by

  have h : (x i) ^ 2 ≤ ∑ j, (x j) ^ 2 :=
    Finset.single_le_sum (f := fun j => (x j) ^ 2) (fun j _ => sq_nonneg _) (Finset.mem_univ i)
  have hnorm : ‖x‖ ^ 2 = ∑ j, (x j) ^ 2 := by
    rw [EuclideanSpace.norm_eq]
    rw [Real.sq_sqrt (by positivity)]
    exact Finset.sum_congr rfl fun j _ => by rw [Real.norm_eq_abs, sq_abs]
  have h2 : |x i| ^ 2 ≤ ‖x‖ ^ 2 := by rw [sq_abs, hnorm]; exact h
  nlinarith [abs_nonneg (x i), norm_nonneg x]
