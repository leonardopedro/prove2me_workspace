-- Generated from ChapterResolventMinMaxLadder.lean — solution of BookProof.ResolventLadder.graphRayleighSet_bddAbove
import Mathlib
import Definitions.Def_ChapterResolventMinMaxLadder
import Theorems.Thm_BookProof_ResolventLadder_graph_unique
open BookProof.ResolventLadder



noncomputable section


open BookProof.RitzMinMax BookProof.ChapterSirkRitzSpectrum BookProof.HermiteGalerkin
open BookProof.NonnegResolvent BookProof.PositiveSquareRoot
open BookProof.NonnegSquareRoot BookProof.ClosureUniqueness
open Filter Topology

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]

variable {F : Type*} [NormedAddCommGroup F] [InnerProductSpace ℂ F] [CompleteSpace F]
variable {T : Submodule ℂ (F × F)}

set_option maxHeartbeats 1000000 in
theorem solution (hsv : ∀ w : F, ((0 : F), w) ∈ T → w = 0)
    {S : Submodule ℂ F} [FiniteDimensional ℂ S] (hdom : InDomain T S) :
    BddAbove (graphRayleighSet T S) := by

  classical
  have hchoose : ∀ y : S, ∃ z : F, ((y : F), z) ∈ T := fun y => hdom (y : F) y.2
  choose f hf using hchoose
  have hadd : ∀ a b : S, f (a + b) = f a + f b := by
    intro a b
    refine graph_unique hsv (hf (a + b)) ?_
    have := T.add_mem (hf a) (hf b)
    simpa using this
  have hsmul : ∀ (c : ℂ) (a : S), f (c • a) = c • f a := by
    intro c a
    refine graph_unique hsv (hf (c • a)) ?_
    have := T.smul_mem c (hf a)
    simpa using this
  let L : S →ₗ[ℂ] F :=
    { toFun := f
      map_add' := hadd
      map_smul' := by
        intro c a
        simpa using hsmul c a }
  let Lc : S →L[ℂ] F := LinearMap.toContinuousLinearMap L
  refine ⟨‖Lc‖, ?_⟩
  rintro t ⟨y, z, hyz, hyS, hy1, rfl⟩
  have hz : z = f ⟨y, hyS⟩ := graph_unique hsv hyz (hf ⟨y, hyS⟩)
  have hnorm : ‖f ⟨y, hyS⟩‖ ≤ ‖Lc‖ := by
    have hb := Lc.le_opNorm ⟨y, hyS⟩
    have hy' : ‖(⟨y, hyS⟩ : S)‖ = 1 := by simpa using hy1
    rw [hy', mul_one] at hb
    simpa [Lc, L, LinearMap.toContinuousLinearMap] using hb
  calc (inner ℂ y z : ℂ).re ≤ ‖(inner ℂ y z : ℂ)‖ := Complex.re_le_norm _
    _ ≤ ‖y‖ * ‖z‖ := norm_inner_le_norm _ _
    _ = ‖z‖ := by rw [hy1, one_mul]
    _ ≤ ‖Lc‖ := by rw [hz]; exact hnorm
