-- Generated from ChapterHarmonicOscillatorEsa.lean — theorem BookProof.HarmonicOscillator.harmonicOsc_not_bounded
import Definitions.Def_ChapterHermiteFunctions
import Definitions.Def_ChapterStrichartzHermiteQG
import Definitions.Def_ChapterFarisLavine
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
open BookProof.HarmonicOscillator



open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

theorem BookProof.HarmonicOscillator.harmonicOsc_not_bounded :
    ¬ ∃ C : ℝ, ∀ f : hermiteCore, ‖harmonicOscOp f‖ ≤ C * ‖(f : L2R)‖ := by sorry
