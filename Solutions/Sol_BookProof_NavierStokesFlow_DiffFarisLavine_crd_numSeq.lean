-- Generated from ChapterNavierStokesDiffFarisLavine.lean — solution of BookProof.NavierStokesFlow.DiffFarisLavine.crd_numSeq
import Mathlib
import Definitions.Def_ChapterNavierStokesDiffFarisLavine
import Definitions.Def_ChapterHermiteProductCore
import Definitions.Def_ChapterHermiteProductBasis
open BookProof.NavierStokesFlow
open BookProof.NavierStokesFlow.DiffFarisLavine














open MvPolynomial
open BookProof.HermiteProductCore BookProof.HermiteProductBasis
open LpNat FarisLavine IkebeKato ThreeComponent CanonicalVector DifferentialL2

noncomputable section

set_option maxHeartbeats 1000000 in
set_option maxHeartbeats 4000000 in
-- The core operators unfold through several linear equivalences on a submodule of `L²(ℝ³)`,
-- so the default heartbeat budget is not enough.
theorem solution (i : Fin 3) (x : lpFiniteModes Vel) (β : Vel) :
    crd (numSeq i x) β = ((β i : ℝ) : ℂ) * crd x β := by

  by_cases h : β i = 0
  · simp [numSeq, cFun, h]
  · have h1 : 1 ≤ β i := Nat.one_le_iff_ne_zero.mpr h
    have hlow : ((lower i β) i : ℝ) + 1 = (β i : ℝ) := by
      rw [lower_self]
      have : (1 : ℕ) ≤ β i := h1
      push_cast [Nat.cast_sub this]
      ring
    have hraise : raise i (lower i β) = β := raise_lower i h1
    have hsq : (Real.sqrt ((β i : ℝ))) * (Real.sqrt (((lower i β) i : ℝ) + 1)) = (β i : ℝ) := by
      rw [hlow, ← Real.sqrt_mul_self (by positivity : (0 : ℝ) ≤ (β i : ℝ))]
      rw [Real.sqrt_mul_self (by positivity : (0 : ℝ) ≤ (β i : ℝ))]
      exact (Real.mul_self_sqrt (by positivity : (0 : ℝ) ≤ (β i : ℝ)))
    simp only [numSeq, LinearMap.comp_apply, crd_cre, crd_ann, cFun, aFun, hraise]
    rw [← mul_assoc, ← Complex.ofReal_mul, hsq]
