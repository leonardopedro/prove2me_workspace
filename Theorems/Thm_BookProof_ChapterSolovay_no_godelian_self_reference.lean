-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.no_godelian_self_reference
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_PhysMeasureBasis
open PhysMeasureBasis
open BookProof.ChapterSolovay


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.no_godelian_self_reference (N : ℕ) (headDist : Measure (_root_.InnerHead N))
    [IsProbabilityMeasure headDist] [NeZero N] :
    ¬ ∃ (Ψ : SolovayHilbertSpace N headDist),
    (∀ (φ : _root_.InnerSpace N → Prop), (φ = (fun _ => True)) ↔ (Ψ = toSolovay N headDist 0)) := by sorry
