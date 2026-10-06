-- Generated from ChapterThermalMaxEntropy.lean — theorem BookProof.ChapterThermalMaxEntropy.shannonEntropy_le_thermalEntropy
import Definitions.Def_ChapterCoherentOccupation
import Definitions.Def_ChapterBoseEinstein
import Mathlib
import Definitions.Def_ChapterThermalMaxEntropy
import Definitions.Def_ChapterCoherentTemperature
open BookProof.ChapterCoherentTemperature
open BookProof.ChapterThermalMaxEntropy

variable {nbar : ℝ}


noncomputable section


open BookProof.ChapterCoherentTemperature BookProof.ChapterCoherentOccupation
open BookProof.ChapterBoseEinstein


theorem BookProof.ChapterThermalMaxEntropy.shannonEntropy_le_thermalEntropy (h : 0 < nbar) (s : Finset ℕ) (p : ℕ → ℝ)
    (hp : ∀ n ∈ s, 0 ≤ p n) (hsum : ∑ n ∈ s, p n = 1)
    (hmean : ∑ n ∈ s, (n : ℝ) * p n = nbar) :
    -∑ n ∈ s, p n * Real.log (p n) ≤ thermalEntropy nbar := by sorry
