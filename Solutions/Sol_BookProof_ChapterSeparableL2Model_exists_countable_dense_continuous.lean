-- Generated from ChapterSeparableL2Model.lean — solution of BookProof.ChapterSeparableL2Model.exists_countable_dense_continuous
import Mathlib
import Definitions.Def_ChapterSeparableL2Model
open BookProof.ChapterSeparableL2Model



noncomputable section

open MeasureTheory TopologicalSpace


open BookProof.ChapterAbelianGelfandModel BookProof.ChapterAbelianCyclicModel
open BookProof.ChapterAbelianDirectSum BookProof.ChapterLinftyMultiplication
open BookProof.ChapterStandardBorelClassification

variable {Y : Type*} [TopologicalSpace Y] [CompactSpace Y] [T2Space Y] [MeasurableSpace Y]
  [BorelSpace Y] (mu : Measure Y) [IsFiniteMeasure mu] [mu.WeaklyRegular]

set_option maxHeartbeats 1000000 in
theorem solution [SeparableSpace (Lp ℂ 2 mu)] :
    ∃ D : Set C(Y, ℂ), D.Countable ∧
      Dense ((fun f : C(Y, ℂ) => ContinuousMap.toLp 2 mu ℂ f) '' D) := by

  classical
  obtain ⟨E, hEc, hEd⟩ := exists_countable_dense (Lp ℂ 2 mu)
  have hdense : DenseRange
      ((ContinuousMap.toLp 2 mu ℂ).toLinearMap : C(Y, ℂ) → Lp ℂ 2 mu) :=
    ContinuousMap.toLp_denseRange ℂ _ (μ := mu) (by simp)
  have hchoice : ∀ (v : Lp ℂ 2 mu) (n : ℕ), ∃ f : C(Y, ℂ),
      dist (ContinuousMap.toLp 2 mu ℂ f) v < 1 / (n + 1) := by
    intro v n
    obtain ⟨b, hb, hdb⟩ := Metric.mem_closure_iff.1 (hdense v) (1 / (n + 1)) (by positivity)
    obtain ⟨f, hf⟩ := hb
    exact ⟨f, by rw [← hf] at hdb; simpa [dist_comm] using hdb⟩
  choose g hg using hchoice
  haveI : Countable E := hEc.to_subtype
  refine ⟨Set.range fun p : E × ℕ => g (p.1 : Lp ℂ 2 mu) p.2, Set.countable_range _, ?_⟩
  rw [Metric.dense_iff]
  intro v ε hε
  obtain ⟨e, heE, hev⟩ := Metric.mem_closure_iff.1 (hEd v) (ε / 2) (by linarith)
  obtain ⟨n, hn⟩ := exists_nat_one_div_lt (show (0:ℝ) < ε / 2 by linarith)
  refine ⟨ContinuousMap.toLp 2 mu ℂ (g e n), ?_, ⟨g e n, ⟨(⟨e, heE⟩, n), rfl⟩, rfl⟩⟩
  refine Metric.mem_ball.2 ?_
  have h1 := hg e n
  have h0 : dist (ContinuousMap.toLp 2 mu ℂ (g e n)) v
      ≤ dist (ContinuousMap.toLp 2 mu ℂ (g e n)) e + dist e v := dist_triangle _ _ _
  have h2 : dist e v < ε / 2 := by simpa [dist_comm] using hev
  linarith
