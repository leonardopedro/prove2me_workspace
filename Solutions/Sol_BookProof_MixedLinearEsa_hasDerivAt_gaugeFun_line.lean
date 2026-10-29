-- Generated from ChapterMixedLinearEsa.lean — solution of BookProof.MixedLinearEsa.hasDerivAt_gaugeFun_line
import Mathlib
import Definitions.Def_ChapterMixedLinearEsa
import Theorems.Thm_BookProof_MixedLinearEsa_hasDerivAt_gaugePhase_line
import Definitions.Def_ChapterStrichartzWave
import Definitions.Def_ChapterFourierMultiplierEsa
import Definitions.Def_ChapterFarisLavine
open BookProof.MixedLinearEsa




open MeasureTheory SchwartzMap FourierTransform ComplexInnerProductSpace LineDeriv
open BookProof.StrichartzWave BookProof.FourierMultiplierEsa BookProof.FarisLavine

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

variable {V : Type*} [NormedAddCommGroup V] [InnerProductSpace ℝ V] [FiniteDimensional ℝ V]
  [MeasurableSpace V] [BorelSpace V]

set_option maxHeartbeats 1000000 in
omit [FiniteDimensional ℝ V] [MeasurableSpace V] [BorelSpace V] in

theorem solution (b m : V) (hm : m ≠ 0) (x : V) :
    HasDerivAt (fun t : ℝ => gaugeFun b m (x + t • m))
      (gaugeFun b m x * (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ))) 0 := by
  -- The published `hasDerivAt_gaugePhase_line` node kept `FiniteDimensional`/`MeasurableSpace`/
  -- `BorelSpace` in its binder list (its `omit` did not survive publication), but this
  -- theorem's context omits them, so we inline the phase-derivative proof — it needs only the
  -- normed-space instances.
  set A : ℝ := inner ℝ x b with hA
  set B : ℝ := inner ℝ m b with hB
  set C : ℝ := inner ℝ x m with hC
  set D : ℝ := ‖m‖ ^ 2 with hD
  have hD0 : D ≠ 0 := by positivity
  have hbm : (inner ℝ b m : ℝ) = B := (real_inner_comm b m).symm
  have hfun : (fun t : ℝ => gaugePhase b m (x + t • m))
      = fun t : ℝ => (-(A + t * B)) * (C + t * D) / D + B * (C + t * D) ^ 2 / (2 * D ^ 2) := by
    funext t
    rw [gaugePhase, inner_add_left, inner_add_left, real_inner_smul_left, real_inner_smul_left,
      hbm, real_inner_self_eq_norm_sq]
    simp only [hA, hB, hC, hD]
    ring
  have hphase : HasDerivAt (fun t : ℝ => gaugePhase b m (x + t • m)) (-(inner ℝ x b : ℝ)) 0 := by
    rw [hfun]
    have h1 : HasDerivAt (fun t : ℝ => A + t * B) B 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const B).const_add A
    have h1n : HasDerivAt (fun t : ℝ => -(A + t * B)) (-B) 0 := h1.neg
    have h2 : HasDerivAt (fun t : ℝ => C + t * D) D 0 := by
      simpa using ((hasDerivAt_id (0 : ℝ)).mul_const D).const_add C
    have h3 := ((h1n.mul h2).div_const D).add (((h2.pow 2).const_mul B).div_const (2 * D ^ 2))
    simp only [Nat.cast_ofNat] at h3
    convert h3 using 1
    all_goals first | rfl | (field_simp; ring) | trace_state
  have h1 : HasDerivAt (fun t : ℝ => ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := hphase.ofReal_comp
  have h2 : HasDerivAt (fun t : ℝ => Complex.I * ((gaugePhase b m (x + t • m) : ℝ) : ℂ))
      (Complex.I * ((-(inner ℝ x b : ℝ) : ℝ) : ℂ)) 0 := h1.const_mul _
  simpa [gaugeFun] using h2.cexp
