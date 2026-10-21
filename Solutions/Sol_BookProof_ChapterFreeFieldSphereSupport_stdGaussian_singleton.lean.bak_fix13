-- Generated from ChapterFreeFieldSphereSupport.lean — solution of BookProof.ChapterFreeFieldSphereSupport.stdGaussian_singleton
import Mathlib
import Definitions.Def_ChapterFreeFieldSphereSupport
open BookProof.ChapterFreeFieldSphereSupport



open MeasureTheory ProbabilityTheory
open BookProof.ChapterFreeFieldGaussian BookProof.ChapterFreeFieldSphere


variable {n : ℕ}

variable {n : ℕ}

set_option maxHeartbeats 1000000 in
theorem solution (hn : 0 < n) (x : EuclideanSpace ℝ (Fin n)) :
    stdGaussian n {x} = 0 := by

  rw [ ChapterFreeFieldGaussian.stdGaussian, Measure.map_apply ];
  · rw [ show ( WithLp.toLp 2 ⁻¹' { x } : Set ( Fin n → ℝ ) ) = { fun i => x i } from ?_ ];
    · convert MeasureTheory.Measure.pi_pi _ _;
      rotate_right;
      focus (exact fun i => { x.ofLp i });
      · aesop;
      · simp only [gaussianReal, one_ne_zero, ↓reduceIte, measure_singleton, Finset.prod_const,
          Finset.card_univ, Fintype.card_fin];
        rw [ zero_pow hn.ne' ];
      · exact fun _ => inferInstance;
    · aesop;
  · fun_prop;
  · exact MeasurableSingletonClass.measurableSet_singleton _
