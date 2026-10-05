-- Generated from ChapterHarmonicOscillatorEsa.lean — solution of BookProof.HarmonicOscillator.harmonicOscOp_hermiteLp
import Mathlib
import Definitions.Def_ChapterHarmonicOscillatorEsa
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteCoreOp_hermiteLp
import Theorems.Thm_BookProof_HermiteStrichartzQG_hermiteLp_mem_hermiteCore
open BookProof.HarmonicOscillator




open MeasureTheory Polynomial BookProof.HermiteCore BookProof.HermiteStrichartzQG
open BookProof.FarisLavine

set_option maxHeartbeats 1000000 in
theorem solution (n : ℕ) :
    harmonicOscOp ⟨hermiteLp n, hermiteLp_mem_hermiteCore n⟩
      = ((harmonicSymbol n : ℂ)) • hermiteLp n := hermiteCoreOp_hermiteLp harmonicSymbol n
