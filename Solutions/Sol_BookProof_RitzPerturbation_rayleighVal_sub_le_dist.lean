-- Generated from ChapterSirkRitzPerturbation.lean — solution of BookProof.RitzPerturbation.rayleighVal_sub_le_dist
import Mathlib
import Definitions.Def_ChapterSirkRitzPerturbation
open BookProof.RitzPerturbation









noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

set_option maxHeartbeats 1000000 in
theorem solution (T T' : F →L[ℂ] F) {x : F} (hx1 : ‖x‖ = 1) :
    rayleighVal T x - rayleighVal T' x ≤ ‖T - T'‖ := by

  have hsplit : rayleighVal T x - rayleighVal T' x = (inner ℂ x ((T - T') x) : ℂ).re := by
    simp [rayleighVal]
  rw [hsplit]
  calc (inner ℂ x ((T - T') x) : ℂ).re ≤ ‖(inner ℂ x ((T - T') x) : ℂ)‖ := Complex.re_le_norm _
    _ ≤ ‖x‖ * ‖(T - T') x‖ := norm_inner_le_norm _ _
    _ ≤ ‖T - T'‖ := by
        have h := (T - T').le_opNorm x
        rw [hx1, mul_one] at h
        rw [hx1, one_mul]
        exact h
