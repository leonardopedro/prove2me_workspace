-- Generated from ChapterLinftyMaximalAbelian.lean — theorem BookProof.ChapterLinftyMaximalAbelian.multOp_indicator_oneLp
import Mathlib
import Definitions.Def_ChapterLinftyMaximalAbelian
import Definitions.Def_ChapterLinftyMultiplication
open BookProof.ChapterLinftyMultiplication
open BookProof.ChapterLinftyMaximalAbelian


noncomputable section

open MeasureTheory ENNReal Complex


open BookProof.ChapterLinftyMultiplication

variable {α : Type*} [MeasurableSpace α] {μ : Measure α} [IsFiniteMeasure μ]


theorem BookProof.ChapterLinftyMaximalAbelian.multOp_indicator_oneLp {s : Set α} (hs : MeasurableSet s) (c : ℂ) :
    multOp (s.indicator fun _ => c) ((memLp_top_const c).indicator hs) (oneLp μ)
      = indicatorConstLp 2 hs (measure_ne_top μ s) c := by sorry
