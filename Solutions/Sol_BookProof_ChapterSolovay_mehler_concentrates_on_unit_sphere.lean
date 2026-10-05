-- Generated from ChapterSolovay.lean — solution of BookProof.ChapterSolovay.mehler_concentrates_on_unit_sphere
import Mathlib
import Definitions.Def_ChapterSolovay
import Theorems.Thm_PhysMehler_mehler_concentrates_on_sphere
open BookProof.ChapterSolovay



open MeasureTheory ProbabilityTheory
open scoped ENNReal Filter Topology

set_option maxHeartbeats 1000000 in
theorem solution :
    ∀ᵐ ω ∂(PhysMehler.MehlerPrior),
    Filter.Tendsto (fun k => PhysHSGaussian.normSq k ω / k) Filter.atTop (nhds 1) := by

  simpa [PhysMehler.MehlerPrior] using PhysMehler.mehler_concentrates_on_sphere
