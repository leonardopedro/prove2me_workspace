-- Generated from ChapterNsOuterFockSingleTime.lean — theorem BookProof.NsOuterFock.nsOuterFock_farisLavine_timeIndependent_singleTime
import Mathlib
import Definitions.Def_ChapterNsOuterFockSingleTime
open BookProof.NsOuterFock










open Filter Topology
open BookProof.FarisLavine BookProof.DirectSumEsa
open BookProof.HermiteProductCore
open BookProof.SqSumOuterFamily BookProof.QgOuterFockFL
open BookProof.EsaClosure BookProof.StoneBridge
open BookProof.ChapterStoneResolvent BookProof.HashimotoShiftInvert
open BookProof.QgTimeIndependent

noncomputable section

variable {bv : Fin 3 → ℝ} {nu lam mu gg : ℝ}
variable {B : ℝ} (hB : 0 ≤ B) (hbv : ∀ j, |bv j| ≤ B) (hnu : |nu| ≤ B) (hlam : |lam| ≤ B)
  (hmu : |mu| ≤ B) (hgg : |gg| ≤ B)

include hB hbv hnu hlam hmu hgg in
theorem BookProof.NsOuterFock.nsOuterFock_farisLavine_timeIndependent_singleTime :
    (EssentiallySelfAdjointOn
        (outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim)
        (dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
          (nsFamily hB hbv hnu hlam hmu hgg).secExt
          (nsFamily hB hbv hnu hlam hmu hgg).flK
          (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel) ∧
      ∀ x : outerCore (nsFamily hB hbv hnu hlam hmu hgg).dim,
        ∃ h : (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)
            ∈ outerFriedDom (nsFamily hB hbv hnu hlam hmu hgg).dim,
          dsFibOp (fun n : ℕ => harmFried ((nsFamily hB hbv hnu hlam hmu hgg).dim n))
              (nsFamily hB hbv hnu hlam hmu hgg).secExt
              (nsFamily hB hbv hnu hlam hmu hgg).flK
              (nsFamily hB hbv hnu hlam hmu hgg).secExt_rel
              ⟨(x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim), h⟩
            = (nsFamily hB hbv hnu hlam hmu hgg).outerHam x) ∧
    ∃ (T : UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim))
      (S : ℕ → UnboundedSelfAdjoint (outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim)),
      IsSelfAdjointExtension (nsFamily hB hbv hnu hlam hmu hgg).outerHam T.op ∧
        (∀ N, IsSelfAdjointExtension
          (SqFamily.truncHam (nsFamily hB hbv hnu hlam hmu hgg) N) (S N).op) ∧
        (∀ t s : ℝ, prop T t s = T.stoneU (t - s)) ∧
        (∀ (t s : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          ‖prop T t s x‖ = ‖x‖) ∧
        (∀ (t s r : ℝ) (x : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim),
          prop T t s (prop T s r x) = prop T t r x) ∧
        (∀ t s h : ℝ, prop T (t + h) (s + h) = prop T t s) ∧
        (∀ y : ℝ → outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
          IsSchrodingerSolution T y → ∀ t s : ℝ, y t = prop T t s (y s)) ∧
        (∀ l : ℝ, l ≠ 0 →
          IsShiftInvertC T.op (((l : ℝ) : ℂ) * Complex.I) (-(T.resCLM l)) ∧
            (∀ N, IsShiftInvertC (S N).op (((l : ℝ) : ℂ) * Complex.I) (-((S N).resCLM l))) ∧
            ∀ u : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim,
              Tendsto (fun N => -((S N).resCLM l u)) atTop (𝓝 (-(T.resCLM l u)))) ∧
        ∀ (v : outerFock (nsFamily hB hbv hnu hlam hmu hgg).dim) (t : ℝ),
          Tendsto (fun N => (S N).stoneU t v) atTop (𝓝 (T.stoneU t v)) := by sorry
