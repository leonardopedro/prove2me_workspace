-- Generated from ChapterSolovay.lean — theorem BookProof.ChapterSolovay.mehler_concentrates_on_unit_sphere
import Mathlib
import Definitions.Def_ChapterSolovay
import Definitions.Def_ChapterA4


open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

theorem BookProof.ChapterSolovay.mehler_concentrates_on_unit_sphere :
    ∀ᵐ ω ∂(PhysMehler.MehlerPrior),
    Filter.Tendsto (fun k => PhysHSGaussian.normSq k ω / k) Filter.atTop (nhds 1) := by sorry
